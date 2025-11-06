# Use Tomcat 8.5 with Java 8
FROM tomcat:8.5.81-jdk8-temurin

# Set environment variables
ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH

# Create directories and restore default Tomcat webapps (homepage)
RUN mkdir -p /etc/ccda/files/validator_configuration/vocabulary/code_repository \
    /etc/ccda/files/validator_configuration/vocabulary/valueset_repository \
    /etc/ccda/files/validator_configuration/scenarios_directory \
    /etc/ccda/files/configs_folder && \
    cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps/

# Copy vocabulary repositories
COPY configs/vocabulary/code_repository/ /etc/ccda/files/validator_configuration/vocabulary/code_repository/
COPY configs/vocabulary/valueset_repository/ /etc/ccda/files/validator_configuration/vocabulary/valueset_repository/

# Copy your WAR file into the webapps folder
COPY referenceccdaservice.war /usr/local/tomcat/webapps/

COPY xml/ccdaReferenceValidatorConfig.xml /etc/ccda/files/configs_folder/
# Install the Tomcat context for the app
COPY xml/referenceccdaservice.xml /usr/local/tomcat/conf/Catalina/localhost/

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
