graph TD
    subgraph "Local Environment"
        Developer[Developer]
    end

    subgraph "Source Code Repository (GitHub)"
        A[Git Push] --> B(GitHub Repository)
    end

    subgraph "CI/CD Pipeline (GitHub Actions)"
        B --> C{Trigger Workflow}
        C --> D{Check for Code Changes}
        D -- "Changes in terraform/" --> E[Trigger Terraform Workflow]
        D -- "Changes in ansible/" --> F[Trigger Ansible Workflow]
        D -- "Changes in webapp/" --> G[Trigger Webapp Workflow]
    end

    subgraph "Terraform Workflow"
        E --> H{OPA Policy Check}
        H -- "Policy Validated" --> I(Terraform Plan)
        I --> J(Terraform Apply)
    end

    subgraph "AWS Cloud Infrastructure"
        J --> K[VPC]
        K --> L[Public Subnet]
        K --> M[Private Subnet]
        L --> N(Application Load Balancer)
        L --> O[ALB Security Group]
        M --> P(EC2 Instances)
        M --> Q[EC2 Security Group]
        N -- "Allows HTTP/80 traffic" --> P
        P -- "SSH/22, HTTP/80" --> P
    end

    subgraph "Ansible Workflow"
        F --> R(Run Ansible Playbook)
        R --> P
    end

    subgraph "Webapp Workflow"
        G --> S(Deploy Webapp)
        S --> P
    end

    subgraph "End User Access"
        T[User] --> N
    end
