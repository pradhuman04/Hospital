class PrivateRoom < Room

    has_one :patient, class_name: "User"
