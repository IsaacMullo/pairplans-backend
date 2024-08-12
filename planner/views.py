from rest_framework import viewsets
from .models import Person, Activity
from .serializers import PersonSerializer, ActivitySerializer

class PersonViewSet(viewsets.ModelViewSet):
    queryset = Person.objects.all()
    serializer_class = PersonSerializer

class ActivityViewSet(viewsets.ModelViewSet):
    queryset = Activity.objects.all()
    serializer_class = ActivitySerializer

    def get_queryset(self):
        queryset = self.queryset
        person_id = self.request.query_params.get('person_id')
        if person_id is not None:
            queryset = queryset.filter(person__id=person_id)
        return queryset