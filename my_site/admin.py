from django.contrib import admin

from .models import Project, Language, Social, Video
# Register your models here.

admin.site.register(Project)
admin.site.register(Language)
admin.site.register(Social)
admin.site.register(Video)