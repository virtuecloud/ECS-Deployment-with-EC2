aws_region = "us-east-1"
cluster_name = "testcluster"

containers={

    container1={

        ecs_desired_count = 1
        image_name = "nginx"
        container_name = "357684650164.dkr.ecr.us-east-1.amazonaws.com/testt:latest" 
        ecs_service_name = "ec2-ecs-service1"
        alb_name = "ec2-ecs-test-alb"
        internal = false
        
        
        container_port=80
        
        envs = [ 
          {name: "key" , value: "values"},
          {name: "test" , value: "success"}
          ]

     }
     container2={

        ecs_desired_count = 1
        image_name = "nginx"
        container_name = "357684650164.dkr.ecr.us-east-1.amazonaws.com/testt:latest" 
        ecs_service_name = "ec2-ecss-service"
        alb_name = "ec2-ecs-alb"
        internal = false
        
        container_port=80
        envs = [ 
          {name: "key" , value: "values"},
          {name: "test" , value: "success"}
          ]
     }
   
    
}   
