from django.core.management.base import BaseCommand
from django.core.management import call_command

class Command(BaseCommand):

    def handle(self, *args, **kwargs):
        fixture = 'tmp/portfolio.json'
        call_command("loaddata", fixture)