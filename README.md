# DevSecOps-End-to-End-Pipeline


# Table of Contents

1. [Introduction](#introduction)
2. [Tools Used](#tools-used)
3. [Pipeline](#pipeline)
4. [AWS Infrastructure](#azure-infrastructure)
5. [Detailed Workflow](#detailed-workflow)
6. [Security Approaches](#security-approaches)
7. [Project Demo](#project-demo)
8. [Screenshots](#screenshots)
9. [Build Outputs](#build-outputs)

## Introduction

**Introduction to GitHub DevSecOps End-to-End Pipeline**

In today’s fast-paced development environment, integrating security into the DevOps pipeline is more crucial than ever. **As I embark on this journey**, I am excited to introduce my GitHub DevSecOps End-to-End Pipeline project. This initiative aims to seamlessly incorporate security measures throughout the software development lifecycle, ensuring robust and resilient applications.

**This project** leverages GitHub’s powerful tools and integrations to create a comprehensive pipeline that addresses security at every stage—from code commit to deployment. **By implementing automated security checks**, vulnerability assessments, and compliance validations, I aim to enhance the overall security posture of the development process. **Furthermore**, this pipeline will enable real-time feedback and proactive threat mitigation, **thus** aligning security practices with continuous integration and continuous deployment (CI/CD) workflows.

**In essence**, my goal is to build a pipeline that not only accelerates development but also integrates security seamlessly into every step. **With this approach**, we can achieve greater efficiency, reduce risk, and ensure that our applications meet the highest security standards. **I look forward to** sharing progress and insights as we move forward with this project.


## Tools Used

# Tools Used in the Project

| Tool       | Logo                                                                                       | Link                                |   | Tool       | Logo                                                                                       | Link                                |   | Tool       | Logo                                                                                       | Link                                |
|------------|--------------------------------------------------------------------------------------------|-------------------------------------|---|------------|--------------------------------------------------------------------------------------------|-------------------------------------|---|------------|--------------------------------------------------------------------------------------------|-------------------------------------|
| Azure      | <img src="https://github.com/eyongca/DevSecOps-End-to-End-Pipeline/blob/main/images/azure.svg" width="20" height="20"> | [Azure](https://azure.microsoft.com/) |   | Ansible    | <img src="https://github.com/eyongca/DevSecOps-End-to-End-Pipeline/blob/main/images/ansible.svg" width="20" height="20"> | [Ansible](https://www.ansible.com/)       |   | Jenkins    | <img src="https://github.com/eyongca/DevSecOps-End-to-End-Pipeline/blob/main/images/jenkins.svg" width="20" height="20"> | [Jenkins](https://www.jenkins.io/) |
| Terraform  | <img src="https://github.com/eyongca/DevSecOps-End-to-End-Pipeline/blob/main/images/terraformio.svg" width="20" height="20"> | [Terraform](https://www.terraform.io/) |   | Docker     | <img src="https://github.com/eyongca/DevSecOps-End-to-End-Pipeline/blob/main/images/docker.svg" width="20" height="20"> | [Docker](https://www.docker.com/)         |   | Vault      | <img src="https://github.com/eyongca/DevSecOps-End-to-End-Pipeline/blob/main/images/vault.svg" width="20" height="20"> | [Vault](https://www.hashicorp.com/products/vault) |
| Linux      | <img src="https://github.com/eyongca/DevSecOps-End-to-End-Pipeline/blob/main/images/linux-icon.svg" width="20" height="20"> | [Linux](https://www.kernel.org/)     |   | Kubernetes | <img src="https://github.com/eyongca/DevSecOps-End-to-End-Pipeline/blob/main/images/kubernetes.svg" width="20" height="20"> | [Kubernetes](https://kubernetes.io/)      |   | Trivy      | <img src="https://github.com/eyongca/DevSecOps-End-to-End-Pipeline/blob/main/images/trivy.svg" width="20" height="20"> | [Trivy](https://aquasecurity.github.io/trivy/) |
| Git        | <img src="https://github.com/eyongca/DevSecOps-End-to-End-Pipeline/blob/main/images/git.svg" width="20" height="20"> | [Git](https://git-scm.com/)           |   | SonarQube  | <img src="https://github.com/eyongca/DevSecOps-End-to-End-Pipeline/blob/main/images/sonarqube.svg" width="20" height="20"> | [SonarQube](https://www.sonarqube.org/)   |   | Maven      | <img src="https://github.com/eyongca/DevSecOps-End-to-End-Pipeline/blob/main/images/maven.svg" width="20" height="20"> | [Maven](https://maven.apache.org/)         |
| GitHub     | <img src="https://github.com/eyongca/DevSecOps-End-to-End-Pipeline/blob/main/images/github.svg" width="20" height="20"> | [GitHub](https://github.com/)       |   | JUnit      | <img src="https://github.com/eyongca/DevSecOps-End-to-End-Pipeline/blob/main/images/junit5.png" width="20" height="20"> | [JUnit](https://junit.org/junit4/)         |   | Selenium   | <img src="https://github.com/eyongca/DevSecOps-End-to-End-Pipeline/blob/main/images/selenium.svg" width="20" height="20"> | [Selenium](https://www.selenium.dev/)     |





## Pipeline
# DevSecOps-End-to-End-Pipeline diagram
![Project Image](https://github.com/eyongca/DevSecOps-End-to-End-Pipeline/blob/main/images/pipeline.webp)


## AWS Infrastructure
<!-- Azure Infrastructure content here -->

## Detailed Workflow

1. **Commit and Push Code**: 
   - The developer commits and pushes the source code to the GitHub repository.

2. **GitHub to Jenkins**: 
   - A GitHub webhook triggers Jenkins upon code push.

3. **Vault Integration**: 
   - Jenkins fetches credentials from Vault using its integration.

4. **Trigger Build**: 
   - Jenkins initiates the build process.

5. **Checkout Code**: 
   - Jenkins checks out the source code from the GitHub repository to the specified branch.

6. **Scan Code**: 
   - The fetched source code is scanned with SonarQube, and the analysis report is sent to the SonarQube server.

7. **Build Application**: 
   - The source code is built using Maven, producing a JAR file (including a WAR file and Tomcat server).

8. **Test Application**: 
   - The built application is tested using JUnit test cases, with reports stored via the SureFire plugin.

9. **Push Artifact**: 
   - The JAR file is pushed to the Ansible server using SCP.

10. **Run Ansible Playbook**: 
    - The Ansible playbook is executed on the Ansible server.

11. **Clean Workspace**: 
    - Compiled, built, and packaged components are deleted from the workspace.

12. **Send Status**: 
    - Build status is sent to GitHub, and both build status and test summary are sent to Slack (notifications are sent on failure at any stage).

13. **Docker Operations**:
    - **Login**: Login to DockerHub with registry credentials.
    - **Build Image**: Build the Docker image, incorporating the JAR file from Jenkins.
    - **Tag & Push Image**: Tag the image with the current Jenkins build number and push it to the registry for update deployments. Re-tag the image as "latest" and push it to DockerHub for initial deployments.
    - **Logout**: Logout from DockerHub.

14. **Vulnerability Scan**: 
    - Use Trivy to scan Docker images for vulnerabilities and secrets, and upload reports to blob storage.

15. **Deployment Check**: 
    - Verify the existence of deployment on the Kubernetes cluster via the master node.
      - **Create Deployment**: If no deployment exists, create one using the latest image.
      - **Update Deployment**: If deployment exists, update it with the tagged image.

16. **Notify Deployment Status**: 
    - Notify Slack of the deployment status (failure at any stage triggers a notification).

17. **Public Access**: 
    - The deployment can be accessed via a static public IP attached to the Nginx ingress controller. A domain name can be attached to this IP.


## Security Approaches
1. **Network Segmentation**: 
   - Each virtual machine (VM) is in its own subnet, with inter-subnet connections blocked by NSG security rules.

2. **NSG Inbound Rules**: 
   - Each VM has specific NSG inbound rules allowing only the necessary ports for respective software.

3. **SSH Security**: 
   - VMs are secured with SSH public key authentication to prevent brute-force attacks. Terraform establishes SSH connections during infrastructure provisioning. Keys can be stored locally for manual VM access.

4. **Credential Management**: 
   - All tool credentials are securely stored in HashiCorp Vault. Jenkins accesses and distributes these credentials via pipeline interpolation to ensure security. Jenkins is chosen for its secure credential storage among the pipeline tools.

## Project Demo
<!-- Project Demo content here -->

## Screenshots
<!-- Screenshots content here -->

## Build Outputs
<!-- Build Outputs content here -->
