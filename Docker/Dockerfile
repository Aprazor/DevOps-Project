FROM openjdk:8

# Add the JAR file to the container
ADD /jarstaging/com/valaxy/demo-workshop/2.1.2/demo-workshop-2.1.2.jar project_f.jar

# Set the entrypoint command to run the JAR file
ENTRYPOINT [ "java", "-jar", "project_f.jar" ]