aws_region = "us-east-1"
cluster_name = "testcluster"
# cluster_arn= "arn:aws:ecs:us-east-1:597544333513:cluster/bhub-frontend-dev" 
# log_name = "poc_log"
containers={

    container1={

        # cluster_name = "bhub-frontend-dev"
        ecs_desired_count = 1
        image_name = "nginx"
        container_name = "357684650164.dkr.ecr.us-east-1.amazonaws.com/testt:latest" 
        ecs_service_name = "ec2-ecs-service1"
        # container_definition_file = "container_definations.json"
        alb_name = "ec2-ecs-test-alb"
        internal = false
         /* cert_arn = "arn:aws:acm:us-east-1:727085843824:certificate/f90c85e2-8f15-4edf-a01e-f29724f5c0fc"  */
        /* repository_name = "entana-backend" */
        
        container_port=80
        # cluster_count=true
        # family_name = "poc-frontend-dev"
        envs = [ 
          {name: "key" , value: "values"},
          {name: "test" , value: "success"}
          ]

     }
     container2={

        # cluster_name = "bhub-frontend-dev"
        ecs_desired_count = 1
        image_name = "nginx"
        container_name = "357684650164.dkr.ecr.us-east-1.amazonaws.com/testt:latest" 
        ecs_service_name = "ec2-ecss-service"
      #  container_definition_file = "container_definations.json"
        alb_name = "ec2-ecs-alb"
        internal = false
        /* cert_arn = "arn:aws:acm:us-east-1:727085843824:certificate/f90c85e2-8f15-4edf-a01e-f29724f5c0fc"  */
        /* repository_name = "graphql" */
        
        container_port=80
        # cluster_count=false
        # family_name = "poc-frontend-dev"
        envs = [ 
          {name: "key" , value: "values"},
          {name: "test" , value: "success"}
          ]
     }
   
    
}   
