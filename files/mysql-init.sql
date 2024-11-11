-- create the databases
CREATE DATABASE IF NOT EXISTS `katib`;
CREATE DATABASE IF NOT EXISTS `kfp_cache`;
CREATE DATABASE IF NOT EXISTS `kfp_metadata`;
CREATE DATABASE IF NOT EXISTS `kfp_pipelines`;

-- grant access to the databases
GRANT ALL PRIVILEGES ON `katib`.* TO 'kubeflow'@'%';
GRANT ALL PRIVILEGES ON `kfp_cache`.* TO 'kubeflow'@'%';
GRANT ALL PRIVILEGES ON `kfp_metadata`.* TO 'kubeflow'@'%';
GRANT ALL PRIVILEGES ON `kfp_pipelines`.* TO 'kubeflow'@'%';