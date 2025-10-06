# Lanchonete Kubernetes Infrastructure

This repository is responsible for defining and managing the Kubernetes infrastructure for the "Lanchonete Na Comanda" application. It leverages Terraform for provisioning the underlying cloud resources and Helm charts for deploying the application components onto the Kubernetes cluster.

## Project Structure

*   `terraform/`: Contains Terraform configurations for provisioning Kubernetes clusters (e.g., EKS, GKE, AKS) and related cloud resources.
    *   `bootstrap/`: Initial Terraform configurations for setting up remote state and basic infrastructure.
    *   `environments/`: Environment-specific Terraform configurations (e.g., `dev`, `prod`).
        *   `dev/`: Terraform files for the development environment, including VPC, EKS cluster, IAM roles for Service Accounts (IRSA), and Helm add-ons.
*   `charts/`: Contains Helm charts for deploying the "Lanchonete Na Comanda" application and its dependencies.
    *   `lanchonete-chart/`: The main Helm chart for the application.
    *   `templates/`: Kubernetes manifest templates used by the Helm chart.

## Technologies Used

*   **Terraform**: Infrastructure as Code (IaC) tool for provisioning and managing cloud resources.
*   **Kubernetes**: Container orchestration platform.
*   **Helm**: Package manager for Kubernetes, used to define, install, and upgrade complex Kubernetes applications.
*   **AWS EKS (or similar)**: Managed Kubernetes service (example, can be adapted for other cloud providers).

## Setup and Deployment

### Prerequisites

*   Terraform CLI installed.
*   `kubectl` CLI installed and configured to connect to your Kubernetes cluster.
*   Helm CLI installed.
*   AWS CLI (or respective cloud provider CLI) configured with appropriate credentials.

### Deployment Steps (Example for AWS EKS)

1.  **Initialize Terraform (Bootstrap)**:
    Navigate to `terraform/bootstrap` and run:
    ```bash
    terraform init
    terraform apply
    ```
    This sets up the remote state backend.

2.  **Deploy Environment Infrastructure**:
    Navigate to your desired environment directory (e.g., `terraform/environments/dev`) and run:
    ```bash
    terraform init
    terraform plan
    terraform apply
    ```
    This will provision the EKS cluster, VPC, and other necessary infrastructure.

3.  **Configure `kubectl`**:
    After EKS cluster creation, update your `kubectl` configuration:
    ```bash
    aws eks update-kubeconfig --name <your-eks-cluster-name> --region <your-aws-region>
    ```

4.  **Deploy Application with Helm**:
    Navigate to the `charts/lanchonete-chart` directory and deploy the application:
    ```bash
    helm upgrade --install lanchonete-app . --namespace lanchonete --create-namespace
    ```
    Adjust `values.yaml` in the Helm chart as needed for your deployment.

## CI/CD Integration

This repository includes CI/CD pipeline configurations (e.g., `ci.yml`, `aws-test.yml`) to automate the deployment process, ensuring consistent and reliable infrastructure and application updates.
