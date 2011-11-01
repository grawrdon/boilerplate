from django.test import TestCase
from django.core.urlresolvers import reverse
from home.views import home


class HomePageTestCase(TestCase):
    """
    Home page tests
    """
    def test_home_page(self):
        response = self.client.get(reverse('home'))
        self.assertEqual(response.status_code, 200)
