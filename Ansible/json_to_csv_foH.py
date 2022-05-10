import json
import csv
# Opening JSON file and loading the data
# into the variable data
with open('foH.json') as json_file:
    data = json.load(json_file)
 
aci_data = data['imdata']
rows = []

for n in aci_data:
    row = []
    for m in n['fabricOverallHealthHist5min']['attributes']:
        row.append(n['fabricOverallHealthHist5min']['attributes'][m])
    rows.append(row)

fields = ['childAction', 'cnt', 'dn','healthAvg', 'healthMax', 'healthMin', 'healthSpct','healthThr', 'healthTr', 'index', 'lastCollOffset','repIntvEnd', 'repIntvStart', 'status'] 

with open('foH.csv', 'w') as f:     
    # using csv.writer method from CSV package
    write = csv.writer(f)  
    write.writerow(fields)
    write.writerows(rows)
 