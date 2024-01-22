#!/bin/bash

# Define variables
USER=read_only
PASS=IiQrE7nd*Plqy8cXef64kfFR5
DATABASE=test

# Create a new user
docker exec -it flectra-psql psql -U flectra -d $DATABASE -c "create user $USER password '$PASS';"

# Usage
docker exec -it flectra-psql psql -U flectra -d $DATABASE -c "grant usage on schema public to $USER;"

# Select
docker exec -it flectra-psql psql -U flectra -d $DATABASE -c "grant select on all tables in schema public TO $USER;"

# Privileges
docker exec -it flectra-psql psql -U flectra -d $DATABASE -c "alter default privileges in schema public grant select on tables to $USER;"

# Replication
# docker exec -it flectra-psql psql -U flectra -d $DATABASE -c "alter user $USER replication;"