FROM tomcat:latest

# Deploy application
COPY referenceccdaservice.war /usr/local/tomcat/webapps/

# Create directories for validator configs
RUN mkdir -p /etc/ccda/files/validator_configuration/vocabulary/code_repository \
    /etc/ccda/files/validator_configuration/vocabulary/valueset_repository \
    /etc/ccda/files/validator_configuration/scenarios_directory \
    /etc/ccda/files/configs_folder

# Copy vocabulary repositories
COPY configs/vocabulary/code_repository/ /etc/ccda/files/validator_configuration/vocabulary/code_repository/
COPY configs/vocabulary/valueset_repository/ /etc/ccda/files/validator_configuration/vocabulary/valueset_repository/

# Copy scenarios
COPY "configs/scenarios/" "/etc/ccda/files/validator_configuration/scenarios_directory/"

# Copy validator main configuration file
COPY xml-configs/ccdaReferenceValidatorConfig.xml /etc/ccda/files/configs_folder/

# Install the Tomcat context for the app
COPY xml-configs/referenceccdaservice.xml /usr/local/tomcat/conf/Catalina/localhost/

EXPOSE 8080

CMD ["catalina.sh", "run"]