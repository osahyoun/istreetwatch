#iStreetWatch

iStreetWatch uses __ruby 2.3.0__ 

## Running iStreetWatch locally

* Clone the repository:

 `git clone git@github.com:osahyoun/istreetwatch.git`

* Navigate into the root directory of the app:

 `cd istreetwatch`

* Install redis and start the redis server.

 see [http://redis.io/topics/quickstart](http://redis.io/topics/quickstart)

* Install gem dependencies:

 `bundle install`

* Run migrations:

 `bin/rake db:migrate`

* Start the server:

 `bin/rails s`

