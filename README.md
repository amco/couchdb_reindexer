# Couchdb Reindexer
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'couchdb_reindexer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install couchdb_reindexer

## Usage

```
bin/couchdb_reindexer

Usage: couchdb_reindexer [options]
    -u, --username [USERNAME]        Username for basic auth. (e.g. 'admin')
    -p, --password [PASSWORD]        Password for basic auth. (e.g. 'secret')
    -H, --host [HOST]                CouchDB Host. (e.g. '192.168.0.1')
    -P, --port [PORT]                CouchDB Port. (default: 5984)
        --protocol [PROTOCOL]        Protocol for HTTP requests. (default: http)
    -h, --help                       Show this message.
    -R, --retries [RETRIES]          Number of times to retry a request before timing out. (default: 10)
    -d, --database DATABASE          CouchDB database. (e.g. 'default')
```
