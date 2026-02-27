# BaselinePackV1

5-minute baseline pack generated from osquery snapshot logs.

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**schema_version** | **object** |  | 
**collector** | **object** |  | 
**host** | **str** |  | 
**generated_at_utc** | **datetime** |  | 
**window_seconds** | **int** |  | 
**window_start_unix** | **int** |  | 
**window_end_unix** | **int** |  | 
**events** | [**List[OsquerySnapshotEventV1]**](OsquerySnapshotEventV1.md) |  | 
**manifest_sha256** | **str** |  | [optional] 

## Example

```python
from vps_secops_client.models.baseline_pack_v1 import BaselinePackV1

# TODO update the JSON string below
json = "{}"
# create an instance of BaselinePackV1 from a JSON string
baseline_pack_v1_instance = BaselinePackV1.from_json(json)
# print the JSON string representation of the object
print(BaselinePackV1.to_json())

# convert the object into a dict
baseline_pack_v1_dict = baseline_pack_v1_instance.to_dict()
# create an instance of BaselinePackV1 from a dict
baseline_pack_v1_from_dict = BaselinePackV1.from_dict(baseline_pack_v1_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


