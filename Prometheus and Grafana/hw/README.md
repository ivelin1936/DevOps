## Homework M6: Prometheus and Grafana

### Assignment
You are expected to create the following:
1. A setup with one virtual machine with Docker installed just like on the practice
    * You can separate the workload on two machines. Either way, adjust the parameters in order to fit within your available resources
2. On the machine(s) run the following
    - Prometheus as container. One instance
    - Grafana as container. One instance
    - The application (goprom) used during the practice. Two instances
3. In terms of measurement, do the following
    - Make Docker to provide metrics, which to be consumed by Prometheus. This should result in one job. For this one, you should research Docker documentation
    - Capture the metrics of the two application instances. This should result in one job with two targets
4. In terms of visualization, create a simple dashboard that has
    - A panel which shows how many containers are on the host (in all states)
    - A panel which shows how many jobs are processed by each goprom application (all result types)
    - 
    
The infrastructure part should be automated as much as possible. Of course, using Vagrant (VirtualBox)
For the rest (Docker, Prometheus, Grafana).
