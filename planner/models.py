from django.db import models

class Person(models.Model):
    name = models.CharField(max_length=100)

class Activity(models.Model):
    person = models.ForeignKey(Person, on_delete=models.CASCADE)
    person_name = models.CharField(max_length=100, blank=True)
    activity = models.CharField(max_length=200)

    def save(self, *args, **kwargs):
        self.person_name = self.person.name
        super(Activity, self).save(*args, **kwargs)