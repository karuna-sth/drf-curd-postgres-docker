from django.urls import path

from curdapp import views

urlpatterns = [
    path('', view=views.UsersList.as_view(), name="user-list"),
    path('<int:pk>', view=views.UsersDetails.as_view(), name='user-details')
]