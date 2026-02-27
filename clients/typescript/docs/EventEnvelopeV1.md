
# EventEnvelopeV1


## Properties

Name | Type
------------ | -------------
`schemaVersion` | any
`eventId` | string
`eventType` | string
`hostId` | string
`collectedAtUtc` | Date
`payload` | object
`labels` | Array&lt;string&gt;

## Example

```typescript
import type { EventEnvelopeV1 } from '@vps-secops/client'

// TODO: Update the object below with actual values
const example = {
  "schemaVersion": null,
  "eventId": null,
  "eventType": null,
  "hostId": null,
  "collectedAtUtc": null,
  "payload": null,
  "labels": null,
} satisfies EventEnvelopeV1

console.log(example)

// Convert the instance to a JSON string
const exampleJSON: string = JSON.stringify(example)
console.log(exampleJSON)

// Parse the JSON string back to an object
const exampleParsed = JSON.parse(exampleJSON) as EventEnvelopeV1
console.log(exampleParsed)
```

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)


