import json
import csv
# Opening JSON file and loading the data
# into the variable data
with open('tenant_faults.json') as json_file:
    data = json.load(json_file)
 
aci_data = data['imdata']
rows = []

for n in aci_data:
    row = []
    for m in n['faultRecord']['attributes']:
        row.append(n['faultRecord']['attributes'][m])
    rows.append(row)

fields = ['ack', 'affected', 'cause', 'changeSet','childAction', 'code', 'created', 'delegated','delegatedFrom', 'descr', 'dn', 'domain','highestSeverity', 'id', 'ind', 'lc', 'modTs','occur', 'origSeverity', 'prevSeverity', 'rule','severity', 'status', 'subject', 'type'] 

with open('tenant_faults.csv', 'w') as f:     
    # using csv.writer method from CSV package
    write = csv.writer(f)  
    write.writerow(fields)
    write.writerows(rows)
 