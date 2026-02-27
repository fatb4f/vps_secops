# IngestPack202Response


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**status** | **str** |  | 
**pack_id** | **str** |  | 

## Example

```python
from vps_secops_client.models.ingest_pack202_response import IngestPack202Response

# TODO update the JSON string below
json = "{}"
# create an instance of IngestPack202Response from a JSON string
ingest_pack202_response_instance = IngestPack202Response.from_json(json)
# print the JSON string representation of the object
print(IngestPack202Response.to_json())

# convert the object into a dict
ingest_pack202_response_dict = ingest_pack202_response_instance.to_dict()
# create an instance of IngestPack202Response from a dict
ingest_pack202_response_from_dict = IngestPack202Response.from_dict(ingest_pack202_response_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


