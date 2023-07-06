data "aws_iam_policy_document" "ec2" {
  statement {
    effect = "Allow"
    principals {
        type = "Service"
        identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ec2" {
  name = "${var.env}-vm-role"
  assume_role_policy = data.aws_iam_policy_document.ec2.json
  managed_policy_arns = [ 
        "arn:aws:iam::aws:policy/AmazonS3FullAccess",
        "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
   ]
}

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.env}-vm-role"
  role = aws_iam_role.ec2.name
}