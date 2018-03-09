# Todo apiblacklist

Set user and password to bd (mysql)
- file `config/database.yml (username, password)`

Execute : 
- `rails db:create`
- `rails db:migrate`

***

## Endpoints

### All abuses
* `http :3000/ or http :3000/v1/abuse_ips (/ => redirect to abuse_ips)`

#### Create report (aka abuse_ip)
* `http POST :3000/v1/abuse_ip/new ip_address="ip_address" isWhitelisted="0/1"`  

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
