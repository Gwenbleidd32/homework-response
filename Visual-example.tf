/*
              San-Francisco                             Tokyo
                     \          User Traffic            / 
                      \-------(Global Requests)--------/
                                      |       ↑       
                                      |       ↑       
                                      |       ↑
---VPC--------------------------------▼-------↑--------------------------------                            
    buckets not included enabled with private access and serverless access                      
                                      │       ↑
                                      │       ↑
                                      │       ↑
                                      │       ↑ 
                                      │----------                           
                                      │ Cloud CDN -> Cached content routed through edgepoints
                                      │----------
                       ┌─────────────────────────────┐ 
                       │    HTTP(S) Load Balancer    │
                       │   (Routes Requests to the   │
                       │     Appropriate Backend)    │ 
                       └──────────────┬──────────────┘ 
                                      │                 
              ┌───────────────────────▼──────────────────────┐
              │                                              │
              │                                              │
┌─────────────▼────────────┐                   ┌─────────────▼────────────┐
│        Bucket 1          │                   │         Bucket 2         │-> Multi Region Buckets
│      (US Region)         │                   │       (Asia Region)      │
│    Stores Static HTML    │                   │    Stores Static HTML    │
└────────────────────────↑─┘                   └──↑───────────────────────┘
                          \                      /           
                           \                    /-> Cloud run deploys WordPress Generated HTML to static Host             
------US-WEST2-BASED SUBNET-\------------------/-------------------------------                          
                             \                /                
                  ┌───────────\──────────────/───────────┐
                  │              Cloud Run               │
                  │     (WordPress image with static     │- Instance serves as lightweight containerized host
                  │           Content Exports)           │
                  └──────────────────────────────────────┘
                                      │                       
                                      │ -> Wordpress image uses managed Cloud SQL DB for infrequent writes.                      
                                      │    
                  ┌───────────────────▼───────────────────┐
                  │             Cloud SQL                 │
                  │   (MySQL Database with Private IP)    │
                  │       Secure Access in VPC)           │
                  └───────────────────────────────────────┘
-------------------------------------------------------------------------------
*/
