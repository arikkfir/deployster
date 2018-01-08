from external_services import ExternalServices
from k8s import K8sResource


class K8sStatefulSet(K8sResource):

    def __init__(self, data: dict, svc: ExternalServices = ExternalServices()) -> None:
        super().__init__(data=data, svc=svc)

    @property
    def force_update(self) -> bool:
        # unfortunately StatefulSet only allows updating a small subset of its fields (eg. you can't add new volumes!)
        # therefor, if the update operation's PATCH fails for 5 times, the statefulset will be recreated (force=true)
        return True
