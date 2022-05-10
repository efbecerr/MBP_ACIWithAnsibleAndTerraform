resource "aci_rest" "syslog_destination" {
  path       = "api/node/mo/uni.json"
  payload = <<EOF
{
    "syslogGroup": {
        "attributes": {
            "dn": "uni/fabric/slgroup-ATX-Syslog-Destination-Terraform",
            "name": "ATX-Syslog-Destination-Terraform",
            "rn": "slgroup-ATX-Syslog-Destination-Terraform",
            "status": "created"
        },
        "children": [
            {
                "syslogConsole": {
                    "attributes": {
                        "dn": "uni/fabric/slgroup-ATX-Syslog-Destination-Terraform/console",
                        "rn": "console",
                        "status": "created"
                    },
                    "children": []
                }
            },
            {
                "syslogFile": {
                    "attributes": {
                        "dn": "uni/fabric/slgroup-ATX-Syslog-Destination-Terraform/file",
                        "rn": "file",
                        "status": "created"
                    },
                    "children": []
                }
            },
            {
                "syslogProf": {
                    "attributes": {
                        "dn": "uni/fabric/slgroup-ATX-Syslog-Destination-Terraform/prof",
                        "rn": "prof",
                        "status": "created"
                    },
                    "children": []
                }
            },
            {
                "syslogRemoteDest": {
                    "attributes": {
                        "dn": "uni/fabric/slgroup-ATX-Syslog-Destination-Terraform/rdst-1.1.1.1",
                        "host": "1.1.1.1",
                        "name": "ATX-Syslog-Server",
                        "rn": "rdst-1.1.1.1",
                        "status": "created"
                    },
                    "children": [
                        {
                            "fileRsARemoteHostToEpg": {
                                "attributes": {
                                    "tDn": "uni/tn-mgmt/mgmtp-default/oob-default",
                                    "status": "created"
                                },
                                "children": []
                            }
                        }
                    ]
                }
            }
        ]
    }
}
  EOF
}


resource "aci_rest" "syslog_source" {
  path       = "api/node/mo/uni.json"
  depends_on = [
    aci_rest.syslog_destination
  ]
  payload = <<EOF

  {
    "syslogSrc": {
        "attributes": {
            "dn": "uni/fabric/moncommon/slsrc-ATX-Syslog-Source-Terraform",
            "name": "ATX-Syslog-Source-Terraform",
            "rn": "slsrc-ATX-Syslog-Source-Terraform",
            "status": "created"
        },
        "children": [
            {
                "syslogRsDestGroup": {
                    "attributes": {
                        "tDn": "uni/fabric/slgroup-ATX-Syslog-Destination-Terraform",
                        "status": "created"
                    },
                    "children": []
                }
            }
        ]
    }
}

  EOF
}



resource "aci_rest" "snmp_destination" {
  path       = "api/node/mo/uni.json"
  payload = <<EOF

  {
    "snmpGroup": {
        "attributes": {
            "dn": "uni/fabric/snmpgroup-ATX-SNMP-Trap-Destination-Terraform",
            "name": "ATX-SNMP-Trap-Destination-Terraform",
            "rn": "snmpgroup-ATX-SNMP-Trap-Destination-Terraform",
            "status": "created"
        },
        "children": [
            {
                "snmpTrapDest": {
                    "attributes": {
                        "dn": "uni/fabric/snmpgroup-ATX-SNMP-Trap-Destination-Terraform/trapdest-2.2.2.2-port-162",
                        "host": "2.2.2.2",
                        "secName": "ATX-SNMP-Terraform",
                        "rn": "trapdest-2.2.2.2-port-162",
                        "status": "created"
                    },
                    "children": [
                        {
                            "fileRsARemoteHostToEpg": {
                                "attributes": {
                                    "tDn": "uni/tn-mgmt/mgmtp-default/oob-default",
                                    "status": "created"
                                },
                                "children": []
                            }
                        }
                    ]
                }
            }
        ]
    }
}

  EOF
}


resource "aci_rest" "snmp_source" {
  path       = "api/node/mo/uni.json"
  depends_on = [
    aci_rest.snmp_destination
  ]
  payload = <<EOF

  {
    "snmpSrc": {
        "attributes": {
            "dn": "uni/fabric/moncommon/snmpsrc-ATX-SNMP-Source-Terraform",
            "incl": "audits,events,faults",
            "name": "ATX-SNMP-Source-Terraform",
            "rn": "snmpsrc-ATX-SNMP-Source-Terraform",
            "status": "created"
        },
        "children": [
            {
                "snmpRsDestGroup": {
                    "attributes": {
                        "tDn": "uni/fabric/snmpgroup-ATX-SNMP-Trap-Destination-Terraform",
                        "status": "created"
                    },
                    "children": []
                }
            }
        ]
    }
}

  EOF
}

resource "aci_rest" "snmpPol" {
  path       = "api/node/mo/uni.json"
  depends_on = [
    aci_rest.snmp_source
  ]
  payload = <<EOF

  {
    "snmpPol": {
        "attributes": {
            "dn": "uni/fabric/snmppol-default",
            "adminSt": "enabled"
        },
        "children": []
    }
}
  
  EOF
}



resource "aci_rest" "snmpCommunityP" {
  path       = "api/node/mo/uni/fabric/snmppol-default/community-ATX-SNMP-Terraform.json"
  depends_on = [
    aci_rest.snmpPol
  ]
  payload = <<EOF

  {
    "snmpCommunityP": {
        "attributes": {
            "dn": "uni/fabric/snmppol-default/community-ATX-SNMP-Terraform",
            "name": "ATX-SNMP-Terraform",
            "status": "created",
            "descr": "Configured with Terraform",
            "rn": "community-ATX-SNMP-Terraform"
        },
        "children": []
    }
}

  

  EOF
}


resource "aci_rest" "snmp_ClientGrpP" {
  path       = "api/node/mo/uni/fabric/snmppol-default/clgrp-ExternalMonitoringServer.json"
  depends_on = [
    aci_rest.snmpCommunityP
  ]
  payload = <<EOF

  {
    "snmpClientGrpP": {
        "attributes": {
            "dn": "uni/fabric/snmppol-default/clgrp-ExternalMonitoringServer",
            "name": "ExternalMonitoringServer",
            "descr": "Configured with Terraform",
            "rn": "clgrp-ExternalMonitoringServer",
            "status": "created"
        },
        "children": [
            {
                "snmpClientP": {
                    "attributes": {
                        "dn": "uni/fabric/snmppol-default/clgrp-ExternalMonitoringServer/client-[2.2.2.2]",
                        "name": "Monitoring-Server",
                        "addr": "2.2.2.2",
                        "rn": "client-[2.2.2.2]",
                        "status": "created"
                    },
                    "children": []
                }
            },
            {
                "snmpRsEpg": {
                    "attributes": {
                        "tDn": "uni/tn-mgmt/mgmtp-default/oob-default",
                        "status": "created"
                    },
                    "children": []
                }
            }
        ]
    }
}

  EOF
}



resource "aci_rest" "fabricPodPGrp" {
  path       = "api/node/mo/uni.json"
  depends_on = [
    aci_rest.snmp_ClientGrpP
  ]
  payload = <<EOF

  {
    "fabricPodPGrp": {
        "attributes": {
            "dn": "uni/fabric/funcprof/podpgrp-ATX-PodPolicyGroup-Terraform",
            "name": "ATX-PodPolicyGroup-Terraform",
            "descr": "Configured with Terraform",
            "rn": "podpgrp-ATX-PodPolicyGroup-Terraform",
            "status": "created"
        },
        "children": [
            {
                "fabricRsSnmpPol": {
                    "attributes": {
                        "tnSnmpPolName": "default",
                        "status": "created,modified"
                    },
                    "children": []
                }
            }
        ]
    }
}
  
  EOF
}


