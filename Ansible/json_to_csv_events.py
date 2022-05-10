import json
import csv
# Opening JSON file and loading the data
# into the variable data
with open('events.json') as json_file:
    data = json.load(json_file)
 
aci_data = data['imdata']
rows = []

for n in aci_data:
    row = []
    for m in n['eventRecord']['attributes']:
        row.append(n['eventRecord']['attributes'][m])
    rows.append(row)

fields = ['affected', 'cause', 'changeSet', 'childAction','code', 'created', 'descr','dn', 'id', 'ind', 'modTs','severity', 'status', 'trig', 'txId', 'user'] 

with open('events.csv', 'w') as f:     
    # using csv.writer method from CSV package
    write = csv.writer(f)  
    write.writerow(fields)
    write.writerows(rows)
 