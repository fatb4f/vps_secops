
# ListPacks200ResponseInner


## Properties

Name | Type
------------ | -------------
`packId` | string
`host` | string
`generatedAtUtc` | Date

## Example

```typescript
import type { ListPacks200ResponseInner } from '@vps-secops/client'

// TODO: Update the object below with actual values
const example = {
  "packId": null,
  "host": null,
  "generatedAtUtc": null,
} satisfies ListPacks200ResponseInner

console.log(example)

// Convert the instance to a JSON string
const exampleJSON: string = JSON.stringify(example)
console.log(exampleJSON)

// Parse the JSON string back to an object
const exampleParsed = JSON.parse(exampleJSON) as ListPacks200ResponseInner
console.log(exampleParsed)
```

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)


