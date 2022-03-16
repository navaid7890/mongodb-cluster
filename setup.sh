#!/bin/bash

mongo <<EOF
   var cfg = {
        "_id": "xelerate",
        "version": 1,
        "members": [
            {
                "_id": 0,
                "host": "ckh-mongo-cluster.xelerate.solutions:30000",
                "priority": 2
            },
            {
                "_id": 1,
                "host": "ckh-mongo-cluster.xelerate.solutions:30001",
                "priority": 1
            },
            {
                "_id": 2,
                "host": "ckh-mongo-cluster.xelerate.solutions:30002",
                "priority": 1
            }
        ]
    };
    rs.initiate(cfg, { force: true });
    //rs.reconfig(cfg, { force: true });
    rs.status();
EOF
sleep 10

mongo <<EOF
   use admin;
   admin = db.getSiblingDB("admin");
   admin.createUser(
     {
	user: "admin",
        pwd: "Invixible@&*90123",
        roles: [ { role: "root", db: "admin" } ]
     });
     db.getSiblingDB("admin").auth("admin", "Invixible@&*90123");
     rs.status();
EOF
