import json
import csv
# Opening JSON file and loading the data
# into the variable data
with open('faults.json') as json_file:
    data = json.load(json_file)
 
aci_data = data['imdata']
rows = []

for n in aci_data:
    row = []
    for m in n['faultSummary']['attributes']:
        row.append(n['faultSummary']['attributes'][m])
    rows.append(row)

fields = ['cause', 'childAction', 'code', 'count','descr', 'dn', 'domain', 'nonAcked','nonDelegated', 'nonDelegatedAndNonAcked', 'rule', 'severity','status', 'subject', 'type'] 

with open('faults.csv', 'w') as f:     
    # using csv.writer method from CSV package
    write = csv.writer(f)  
    write.writerow(fields)
    write.writerows(rows)
 