import hudson.security.HudsonPrivateSecurityRealm
import jenkins.install.InstallState
import jenkins.model.Jenkins
import hudson.security.GlobalMatrixAuthorizationStrategy


def instance = Jenkins.getInstanceOrNull()

instance.setInstallState(InstallState.INITIAL_SETUP_COMPLETED)

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
def adminUsername = System.getenv('JENKINS_ADMIN_USERNAME') ?: 'admin'
def adminPassword = System.getenv('JENKINS_ADMIN_PASSWORD') ?: 'password'
hudsonRealm.createAccount(adminUsername, adminPassword)
//hudsonRealm.createAccount("charles", "charles")

// def instance = Jenkins.getInstance()
instance.setSecurityRealm(hudsonRealm)
def strategy = new GlobalMatrixAuthorizationStrategy()
strategy.add(Jenkins.ADMINISTER, System.getenv('JENKINS_ADMIN_USERNAME') ?: 'admin')
instance.setAuthorizationStrategy(strategy)

// EC2 Plugin
// K8s dynamic credentials

instance.save()