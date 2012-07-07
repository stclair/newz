import datetime

from django.conf import settings

from armstrong.core.arm_sections.backends import PublishedItemFilter

class MadItemFilter(PublishedItemFilter):

    def process_items(self, items):
        items = items.filter(pub_date__gte=datetime.date.today() - datetime.timedelta(settings.MAD_NUM_DAYS_TO_DISPLAY))
        return super(MadItemFilter, self).process_items(items)