output "lb_target_group_id" {
  value       = try(aws_alb_target_group.this[0].id, null)
  description = "ARN of the Target Group."
}

output "name" {
  value       = var.name
  description = "Service name."
}

output "service_id" {
  value       = aws_ecs_service.this.id
  description = "ARN that identifies the service."
}

output "task_role_id" {
  value       = aws_iam_role.task_role.id
  description = "ECS task role ID"
}

output "task_execution_role_id" {
  value       = aws_iam_role.task_execution.id
  description = "ECS task execution role ID"
}

output "deployment_group" {
  value       = aws_iam_group.deployment.name
  description = "Deployment group name"
}

output "deployment_group_arn" {
  value       = aws_iam_group.deployment.arn
  description = "Deployment group ARN"
}

output "task_template" {
  description = "Task json template for service"
  value = <<JSON
{
  "family": "${random_id.prefix.hex}",
  "containerDefinitions": [
    {
      "name": "${var.name}",
      "image": "",
      "cpu": 0,
      "memory": 0,
      "essential": true,
      "portMappings": ${jsonencode(local.is_worker ? [] : [
          for port in var.tcp_ports :
          {
            containerPort = port.container,
            hostPort      = port.host,
            protocol      = "tcp",
            name          = port.name,
          }
        ])},
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.this.name}",
          "awslogs-region": "${data.aws_region.this.name}",
          "awslogs-stream-prefix": "ecs"
        }
      }
    }
  ],
  "networkMode": "bridge",
  "executionRoleArn": "${aws_iam_role.task_execution.arn}",
  "taskRoleArn": "${aws_iam_role.task_role.arn}",
  "requiresCompatibilities": [
    "EC2"
  ]
}
  JSON
}


output "task_one_off_template" {
  description = "Task json template for one-off commands"
  value = {
 for name, svc in var.one_off_commands :
    name => (
  <<JSON
{
  "family": "${random_id.prefix.hex}-${name}",
  "containerDefinitions": [
    {
      "name": "${var.name}",
      "command": ["${name}"],
      "image": "",
      "cpu": 200,
      "memory": 200,
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.one_off[name].name}",
          "awslogs-region": "${data.aws_region.this.name}",
          "awslogs-stream-prefix": "ecs"
        }
      }
    }
  ],
  "networkMode": "bridge",
  "executionRoleArn": "${aws_iam_role.task_execution.arn}",
  "taskRoleArn": "${aws_iam_role.task_role.arn}",
  "requiresCompatibilities": [
    "EC2"
  ]
}
  JSON
)
  }
}

