<<<<<<< HEAD
FactoryBot.define do
    factory :exercise do
        title { 'Pushups' }
        description { 'Pushups Description' }
        picture {'https://www.picture_link.com'}
        unit_name {'time'}
    end

    factory :workout_post do
        title {'Workout Post Title'}
        date_created {Date.today}
    end

    factory :exercise_post do 
        association :exercise
        association :workout_post
        specific_instructions {'Specific Instructions'}
        
        trait :ranked do
            is_ranked {true}
        end
    end

    factory :user do 
        email {'fake_email@tamu.edu'}
        full_name {'fake name'}
        uid {'fake name'}
        avatar_url {'https://fake_url.com'}
        description {'fake description'}
        
        trait :admin do
            is_admin {true}
        end
    end

    factory :workout_submission do
        association :user
        association :workout_post
        submitted_datetime {DateTime.now}
    end

    factory :exercise_submission do
        association :exercise_post
        association :workout_submission
        unit_value {'150'}
    end

end
=======
# frozen_string_literal: true

FactoryBot.define do
  factory :exercise do
    title { 'Pushups' }
    description { 'Pushups Description' }
    picture { 'https://www.picture_link.com' }
    unit_name { 'time' }
  end

  factory :workout_post do
    title { 'Workout Post Title' }
  end

  factory :exercise_post do
    association :exercise
    association :workout_post
    specific_instructions { 'Specific Instructions' }

    trait :ranked do
      is_ranked { true }
    end
  end

  factory :user do
    email { 'fake_email@tamu.edu' }
    full_name { 'fake name' }
    uid { 'fake name' }
    avatar_url { 'https://fake_url.com' }
    description { 'fake description' }

    trait :admin do
      is_admin { true }
    end
  end

  factory :workout_submission do
    association :user
    association :workout_post
    submitted_datetime { DateTime.now }
  end

  factory :exercise_submission do
    association :exercise_post
    association :workout_submission
    association :user
    unit_value { '150' }
  end
end
>>>>>>> 9645f30515eed86ee65f4943cf8cf17dbfec771b
