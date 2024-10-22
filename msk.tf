resource "aws_msk_cluster" "msk_cluster" {
  cluster_name           = var.cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.num_brokers
  broker_node_group_info {
    instance_type   = var.broker_instance_type
    client_subnets  = [aws_subnet.navin_subnet1.id, aws_subnet.navin_subnet2.id, aws_subnet.navin_subnet3.id]
    security_groups = [var.security_group_ids]
    depends_on           = [aws_vpc.navin.id]
    storage_info {
      ebs_storage_info {
        volume_size = 100
      }
    }
  }
  encryption_info {
    encryption_in_transit {
      client_broker = "TLS"
      in_cluster    = true
    }
  }
  configuration_info {
    arn      = aws_msk_configuration.msk_configuration.arn
    revision = aws_msk_configuration.msk_configuration.latest_revision
  }
  enhanced_monitoring = "PER_BROKER"
  client_authentication {
    sasl {
      iam = true
    }
  }
}

resource "aws_msk_configuration" "msk_configuration" {
  kafka_versions = ["2.6.1"]
  name           = "msk_configuration"

  server_properties = <<PROPERTIES
auto.create.topics.enable = true
delete.topic.enable = true
PROPERTIES
}
