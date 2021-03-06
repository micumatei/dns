#!/bin/bash -e


if [[ "$TRAVIS_PULL_REQUEST" == "false" ]] & [[ "$TRAVIS_BRANCH" == "master" ]]; then
    echo "Building push on master, publish docs"
    # Settings
    REPO_PATH=git@github.com:micumatei/dns.git
    HTML_PATH=html
    COMMIT_USER="Documentation Builder"
    COMMIT_EMAIL="micumatei@gmail.com"
    CHANGESET=$(git rev-parse --verify HEAD)

    # Get a clean version of the HTML documentation repo.
    rm -rf ${HTML_PATH}
    mkdir -p ${HTML_PATH}
    git clone -b gh-pages "${REPO_PATH}" --single-branch ${HTML_PATH}

    # rm all the files through git to prevent stale files.
    cd ${HTML_PATH}
    git rm -rf .
    cd -

    # Generate the HTML documentation.
    make doxygen

    # Create and commit the documentation repo.
    cd ${HTML_PATH}
    git add .
    git config user.name "${COMMIT_USER}"
    git config user.email "${COMMIT_EMAIL}"
    git commit -m "Automated documentation build for changeset ${CHANGESET}."
    git push origin gh-pages
    cd -
else
    echo "Not push on master, skip docs build" 
fi
