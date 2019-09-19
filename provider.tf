provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc" "main" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"
  tags = {
    Name     = "main"
    Location = "Banglore"
  }
}
resource "aws_subnet" "subnets" {
  #it will get list of azs names region wise with the healp of data source
  count      = "${length(data.aws_availability_zones.azs.names)}" 
  # it will pick list of azs name with count and name of azs  with the healp of data source
  availability_zone = "${element(data.aws_availability_zones.azs.names, count.index)}"
  
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${element(var.subnet_cidr, count.index)}"

  tags = {
    Name = "subnet-${count.index+1}"
  }
}
