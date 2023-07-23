from django.db import models
from .validators import validate_file_size


class Project(models.Model):
    name = models.CharField(max_length=120)
    description = models.TextField(blank=True)
    technologies = models.ManyToManyField('Language')
    photo = models.ImageField(upload_to='photos/%Y/%m/%d/')
    active = models.BooleanField(default=True)
    github = models.URLField(max_length=200, blank=True)
    live_demo = models.URLField(max_length=200, blank=True)

    def __str__(self):
        return self.name


class Language(models.Model):
    title = models.CharField(max_length=120)

    def __str__(self):
        return self.title


class Social(models.Model):
    github = models.URLField(max_length=200, blank=True)
    linkedin = models.URLField(max_length=200, blank=True)
    email = models.EmailField(max_length=200, blank=True)
    resume = models.FileField(
        upload_to='documents/%Y/%m/%d/', validators=[validate_file_size], null=True)

    def __str__(self):
        return self.email


class Video(models.Model):
    title = models.CharField(max_length=120)
    videofile = models.FileField(upload_to='videos/%Y/%m/%d/', null=True)

    def __str__(self):
        return self.title
