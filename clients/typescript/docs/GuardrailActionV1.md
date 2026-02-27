
# GuardrailActionV1


## Properties

Name | Type
------------ | -------------
`schemaVersion` | any
`actionId` | string
`actionType` | string
`target` | string
`status` | string
`startedAtUtc` | Date
`endedAtUtc` | Date
`resultMessage` | string
`rollbackRef` | string

## Example

```typescript
import type { GuardrailActionV1 } from '@vps-secops/client'

// TODO: Update the object below with actual values
const example = {
  "schemaVersion": null,
  "actionId": null,
  "actionType": null,
  "target": null,
  "status": null,
  "startedAtUtc": null,
  "endedAtUtc": null,
  "resultMessage": null,
  "rollbackRef": null,
} satisfies GuardrailActionV1

console.log(example)

// Convert the instance to a JSON string
const exampleJSON: string = JSON.stringify(example)
console.log(exampleJSON)

// Parse the JSON string back to an object
const exampleParsed = JSON.parse(exampleJSON) as GuardrailActionV1
console.log(exampleParsed)
```

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)


