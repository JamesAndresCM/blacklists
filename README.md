# Blacklists API

Set user and password to bd (mysql)
- file `config/database.yml (username, password)`

Execute : 
- `rails db:create`
- `rails db:migrate`

***

Or use Docker
***
- Create container bd
* `docker run --name=db_rails -e MYSQL_DATABASE=blacklist_development -e MYSQL_USER=blacklist -e MYSQL_PASSWORD=user_pass -e MYSQL_ROOT_PASSWORD=root_pass -p 3306:3306 -d mariadb`

- Build Dockerfile for rails
* `docker build -t blacklist_rails_5 .`

- Create migration
* `docker run --rm --link=db_rails:db_rails -e DB_HOST=db_rails -e DB_USER=blacklist -e DB_NAME=blacklist_development -e BLACKLIST_DATABASE_PASSWORD=user_pass blacklist_rails_5 rake db:migrate`

- Create container rails
* `docker run --name=rails_blacklist --link=db_rails:db_rails -p 3000:3000 -e DB_HOST=db_rails -e DB_USER=blacklist -e DB_NAME=blacklist_development -e BLACKLIST_DATABASE_PASSWORD=user_pass -d blacklist_rails_5`

## Endpoints

### All abuses
* `http :3000/ or http :3000/v1/abuse_ips (/ => redirect to abuse_ips)`

#### Create report (aka abuse_ip)
* `http POST :3000/v1/abuse_ip/new ip_address="ip_address" isWhitelisted="0/1" category_ip_blacklist="category_ip_blacklist"`  

#### Search report (aka search abuse_ip)
* `http :3000/v1/abuse_ips/search_ip?ip_address="ip_address"`

#### Show per id
* `http :3000/v1/abuse_ip/:id`

#### Delete report
* `http DELETE :3000/v1/abuse_ip/delete/:id`

#### Update report
* `http PUT :3000/v1/abuse_ip/update/:id (ip_address="ip_address" isWhitelisted="0/1")`

***

### All Blacklist

#### Create blacklist
* `http :3000/v1/blacklist/new ip_address="ip_address" central_report="central_report" status_ip="status_ip" hostname="hostname" url_central_report="url_central_report"`

#### Search Blacklist
* `http :3000/v1/blacklist/search_blacklist?ip_address=ip_address`

#### Delete Blacklist
* `http DELETE :3000/v1/blacklist/delete/:id`
