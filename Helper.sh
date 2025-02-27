#!/bin/bash
# Save as create-release-tag.sh

# Check if the required arguments are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 <CRQ_NUMBER> <API_NAME> [RELEASE_DATE]"
    echo "Example: $0 CRQ12345 payment-api"
    exit 1
fi

CRQ_NUMBER=$1
API_NAME=$2
RELEASE_DATE=${3:-$(date +%Y-%m-%d)}  # Use current date if not specified

# Validate CRQ format
if ! [[ $CRQ_NUMBER =~ ^CRQ[0-9]{5}$ ]]; then
    echo "ERROR: CRQ Number must be in format CRQXXXXX (5 digits)"
    exit 1
fi

# Validate date format
if ! [[ $RELEASE_DATE =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    echo "ERROR: Release date must be in format YYYY-MM-DD"
    exit 1
fi

# Create the tag
TAG_NAME="${CRQ_NUMBER}-${API_NAME}-${RELEASE_DATE}-release"
echo "Creating tag: $TAG_NAME"

# Create and push the tag
git tag $TAG_NAME
git push origin $TAG_NAME

echo "Tag created and pushed successfully!"
echo "Deployment workflow should start automatically."
