terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "demo1" {
  name     = "test9"
  location = "West Europe"
}

resource "azurerm_template_deployment" "test7890_1629361955332" {
  name = "test7890_1629361955332"

  deployment_mode     = "Incremental"
  resource_group_name = "demo1"

  template_body = <<DEPLOY



  {
    "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "location": {
            "type": "String"
        },
        "storageAccountName": {
            "type": "String"
        },
        "accountType": {
            "type": "String"
        },
        "kind": {
            "type": "String"
        },
        "accessTier": {
            "type": "String"
        },
        "minimumTlsVersion": {
            "type": "String"
        },
        "supportsHttpsTrafficOnly": {
            "type": "Bool"
        },
        "allowBlobPublicAccess": {
            "type": "Bool"
        },
        "allowSharedKeyAccess": {
            "type": "Bool"
        },
        "defaultOAuth": {
            "type": "Bool"
        },
        "networkAclsBypass": {
            "type": "String"
        },
        "networkAclsDefaultAction": {
            "type": "String"
        },
        "isContainerRestoreEnabled": {
            "type": "Bool"
        },
        "isBlobSoftDeleteEnabled": {
            "type": "Bool"
        },
        "blobSoftDeleteRetentionDays": {
            "type": "Int"
        },
        "isContainerSoftDeleteEnabled": {
            "type": "Bool"
        },
        "containerSoftDeleteRetentionDays": {
            "type": "Int"
        },
        "changeFeed": {
            "type": "Bool"
        },
        "isVersioningEnabled": {
            "type": "Bool"
        },
        "isShareSoftDeleteEnabled": {
            "type": "Bool"
        },
        "shareSoftDeleteRetentionDays": {
            "type": "Int"
        }
    },
    "variables": {},
    "resources": [
        {
            "type": "Microsoft.Storage/storageAccounts",
            "apiVersion": "2021-06-01",
            "name": "[parameters('storageAccountName')]",
            "location": "[parameters('location')]",
            "dependsOn": [],
            "tags": {},
            "sku": {
                "name": "[parameters('accountType')]"
            },
            "kind": "[parameters('kind')]",
            "properties": {
                "accessTier": "[parameters('accessTier')]",
                "minimumTlsVersion": "[parameters('minimumTlsVersion')]",
                "supportsHttpsTrafficOnly": "[parameters('supportsHttpsTrafficOnly')]",
                "allowBlobPublicAccess": "[parameters('allowBlobPublicAccess')]",
                "allowSharedKeyAccess": "[parameters('allowSharedKeyAccess')]",
                "defaultToOAuthAuthentication": "[parameters('defaultOAuth')]",
                "networkAcls": {
                    "bypass": "[parameters('networkAclsBypass')]",
                    "defaultAction": "[parameters('networkAclsDefaultAction')]",
                    "ipRules": []
                }
            }
        },
        {
            "type": "Microsoft.Storage/storageAccounts/blobServices",
            "apiVersion": "2021-06-01",
            "name": "[concat(parameters('storageAccountName'), '/default')]",
            "dependsOn": [
                "[concat('Microsoft.Storage/storageAccounts/', parameters('storageAccountName'))]"
            ],
            "properties": {
                "restorePolicy": {
                    "enabled": "[parameters('isContainerRestoreEnabled')]"
                },
                "deleteRetentionPolicy": {
                    "enabled": "[parameters('isBlobSoftDeleteEnabled')]",
                    "days": "[parameters('blobSoftDeleteRetentionDays')]"
                },
                "containerDeleteRetentionPolicy": {
                    "enabled": "[parameters('isContainerSoftDeleteEnabled')]",
                    "days": "[parameters('containerSoftDeleteRetentionDays')]"
                },
                "changeFeed": {
                    "enabled": "[parameters('changeFeed')]"
                },
                "isVersioningEnabled": "[parameters('isVersioningEnabled')]"
            }
        },
        {
            "type": "Microsoft.Storage/storageAccounts/fileservices",
            "apiVersion": "2021-06-01",
            "name": "[concat(parameters('storageAccountName'), '/default')]",
            "dependsOn": [
                "[concat('Microsoft.Storage/storageAccounts/', parameters('storageAccountName'))]",
                "[concat(concat('Microsoft.Storage/storageAccounts/', parameters('storageAccountName')), '/blobServices/default')]"
            ],
            "properties": {
                "shareDeleteRetentionPolicy": {
                    "enabled": "[parameters('isShareSoftDeleteEnabled')]",
                    "days": "[parameters('shareSoftDeleteRetentionDays')]"
                }
            }
        }
    ],
    "outputs": {}
}

DEPLOY
}