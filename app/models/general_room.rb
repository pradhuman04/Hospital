class GenralRoom < Room

    has_many :patient, class_name: "User"