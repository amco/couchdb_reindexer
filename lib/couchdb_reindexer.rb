require 'couchdb_reindexer/version'
require 'net/http'
require 'uri'
require 'json'

module CouchdbReindexer
  class Indexer
    attr_writer :options

    @@default_options = {
      database: "database",
      host: "127.0.0.1",
      protocol: "http",
      port: "5984",
      retries: 10
    }

    def initialize(options)
      @options = @@default_options.merge!(options)
      puts "***************************************************************"
      puts "********************** RUNNING REINDEXER **********************"
      puts "ON: #{default_url}"
      puts "***************************************************************"
      run
    end

    def run
      docs = get_docs
      if docs.to_json != '[{}]'
        docs = docs['rows']
        docs.each do |doc|
          puts "Document: #{doc['doc']['_id']}"
          doc['doc']['views'].each do |view|
            puts "\tRequesting view: #{doc['doc']['_id']}/_view/#{view[0]}"
            response = make_request(view_uri(doc['doc']['_id'], view[0]))
            if response.code == '200'
              puts "\tResponse status: OK!"
            else
              puts "\tResponse status: Error!"
            end
          end
        end
      else
        puts 'The database is empty or not reachable.'
      end
    end

    def default_url
      "#{@options[:protocol]}://#{@options[:host]}:#{@options[:port]}/#{@options[:database]}"
    end

    def docs_uri
      URI.parse("#{default_url}/_all_docs?startkey=%22_design/%22&endkey=%22_design0%22&include_docs=true")
    end

    def view_uri(document_name, view_name)
      URI.parse("#{default_url}/#{document_name}/_view/#{view_name}")
    end

    def get_docs
      docs_request = make_request(docs_uri)
      docs_json = '[{}]'
      docs_json = docs_request.body if docs_request.code == '200'
      JSON.parse(docs_json)
    end

    def make_request(url, retries = 1)
      raise Net::ReadTimeout if retries.negative?
      request = Net::HTTP::Get.new(url)

      if @options[:username] && @options[:password]
        request.basic_auth @options[:username], @options[:password]
      end

      begin
        Net::HTTP.start(url.hostname, url.port) { |http| http.request(request) }
      rescue Net::ReadTimeout
        make_request(url, retries - 1)
      end
    end
  end
end
