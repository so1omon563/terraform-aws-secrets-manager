# A dedicated place for variables means they will always be able to be easily found.

variable "exclude_characters" {
  description = "String of the characters that you don't want in the password."
  type        = string
  default     = null
}

variable "exclude_lower_case" {
  description = "Specifies whether to exclude lowercase letters from the password."
  type        = bool
  default     = false
}

variable "exclude_numbers" {
  description = "Specifies whether to exclude numbers from the password."
  type        = bool
  default     = false
}

variable "exclude_punctuation" {
  description = <<EOT
 Specifies whether to exclude the following punctuation characters from the password: `! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ .`
EOT
  type        = bool
  default     = false
}

variable "exclude_upper_case" {
  description = "Specifies whether to exclude uppercase letters from the password."
  type        = bool
  default     = false
}

variable "include_space" {
  description = "Specifies whether to include the space character in the password."
  type        = bool
  default     = false
}

variable "password_length" {
  description = "The length of the password."
  type        = number
  default     = 24
}

variable "require_each_included_type" {
  description = "Specifies whether to include at least one upper and lowercase letter, one number, and one punctuation."
  type        = bool
  default     = false
}
