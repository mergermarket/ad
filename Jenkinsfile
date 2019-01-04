pipeline {
    agent {
        node {
            label "swarm2"
        }
    }

    stages {
        stage("NPM Config") {
            steps {
                ansiColor("xterm") {
                    writeNpmConfig()
                }
            }
        }

        stage("Docker Build") {
            steps {
                ansiColor("xterm") {
                    sh "docker build -t active-directory-library --pull ."
                }
            }
        }

        /*stage("Test") {
            steps {
                ansiColor("xterm") {
                    sh "docker run active-directory-library yarn test"
                }
            }
        }*/


        stage("Publish") {
            /* we build only on the master branch currently so it's skipped
            when {
                branch "master"
            }
            */
            steps {
                ansiColor("xterm") {
                    sh "docker run active-directory-library ./idempotent-publish.sh"
                }
            }
        }
    }
}

def writeNpmConfig() {
    withCredentials([usernamePassword(credentialsId: "mmrepo-publish", passwordVariable: "NPM_PASSWORD", usernameVariable: "NPM_USERNAME")]) {
        sh "curl -fsSu $NPM_USERNAME:$NPM_PASSWORD https://mmrepo.jfrog.io/mmrepo/api/npm/auth > .npmrc"
        sh "echo registry = https://mmrepo.jfrog.io/mmrepo/api/npm/npm-virtual >> .npmrc"
    }
}
