FROM tomcat:9.0-jdk17-temurin

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR into Tomcat
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
