# CRM Data ETL Pipeline

This document will guide you through running the CRM Data ETL Pipeline, which utilizes Apache Airflow for orchestrating ETL processes to handle CRM data. Below you'll find the steps to run the project with Docker and initialize the necessary components.

## **Project Setup and Requirements**

### **Prerequisites**

- Docker and Docker Compose installed on your system
- Python 3.11 and a virtual environment tool (e.g., Poetry or Make)
- Basic understanding of Airflow and ETL processes

### **Step 1: Clone the Repository**

First, clone the repository to your local system:

```bash
$ git clone <repository-url>
$ cd crm_data_etl_pipeline
```

### **Step 2: Setup Python Environment**

Activate your virtual environment and install dependencies using Poetry:

```bash
$ poetry install
```

Ensure you're using Python 3.11 to match the Airflow setup.

### **Step 3: Run Docker Containers**

Run the Docker containers using `docker-compose`. This will spin up both the Postgres and Airflow containers.

```bash
$ docker-compose up
```

To run commands inside the Airflow container:

```bash
$ docker exec -it <airflow-container-name> /bin/bash
```
Replace `<airflow-container-name>` with your specific Airflow container name, which you can get from `docker ps`.

### **Step 4: Initialize Airflow Database**

Once inside the Airflow container, initialize the Airflow database by running:

```bash
root@<container-id>:/app# airflow db init
```

This will also create the necessary tables in your Postgres database.

### **Step 5: Create Airflow User**

To create a new admin user for Airflow, run:

```bash
root@<container-id>:/app# airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com
```

### **Step 6: Running Airflow Webserver**

To start the Airflow webserver:

```bash
root@<container-id>:/app# airflow webserver
```

The Airflow webserver will be available at [http://localhost:8080](http://localhost:8080).

### **Step 7: Running Airflow Scheduler**

In another terminal window, attach to the running Airflow container and start the scheduler:

```bash
$ docker exec -it <airflow-container-name> /bin/bash
root@<container-id>:/app# airflow scheduler
```

This will start the Airflow scheduler to execute DAGs at their defined schedules.

## **Accessing the Airflow UI**

After starting the webserver, you can access the Airflow UI at [http://localhost:8080](http://localhost:8080).
Use the credentials you created earlier (`admin` / `your_password`) to log in.

### **Step 8: Trigger a DAG**

Navigate to the Airflow UI, and you can see all your DAGs. You can trigger a DAG by switching its toggle to "On" and then manually starting it.

## **Troubleshooting Tips**

- Ensure your Postgres container is running before initializing the Airflow database.
- If you encounter errors related to database connectivity, check your Postgres container logs.
- Reset your password using the Airflow CLI if you forget your login credentials.
