class CreatePrivacyPolicies < ActiveRecord::Migration[6.1]
  class PrivacyPolicy < ActiveRecord::Base
  end

  def change
    create_table :privacy_policies, id: :uuid do |t|
      t.string :version, null: false
      t.text :html, null: false

      t.index :version, unique: true

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        PrivacyPolicy.create(
          version: "1.0",
          html: <<~PRIVACY_POLICY
          <h1 class="govuk-heading-l">How we look after your personal data</h1>
            <h2 class="govuk-heading-m">Department for Education (DfE)</h2>
              <p class="govuk-body">Mentions of "us" and "we" mean DfE and "you" means anyone using this service.</p>
              <p class="govuk-body">This work is being carried out by Get Teacher Professional Development, which is a part of the Department for Education (DfE).</p>
              <p class="govuk-body">Any information we collect when you use our services will be used and looked after by:</p>
                <ul class="govuk-list govuk-list--bullet">
                  <li>the Department for Education, and/or </li>
                  <li>the teacher training providers the candidate applies to</li>
                </ul>
              <p class="govuk-body">This means we’re joint data controllers, as well as data processors, for your information (defined by data protection law).</p>
              <p class="govuk-body">Manage Training for Early Career Teachers is a new service.  We’re confident that it has met our security standards, but we’ll continue to run security tests as we improve the service.</p>

            <h2 class="govuk-heading-m">What personal data we collect</h2>
              <p class="govuk-body">The personal data we collect will depend on whether you’re an early career teacher, mentor, induction tutor/coordinator or a training provider.</p>
              <h3 class="govuk-heading-s">What data we collect if you're an early career teacher</h3>
                <p class="govuk-body">If you’re an early career teacher using Manage Training For Early Career Teachers we may collect the following information about you:</p>
                <ul class="govuk-list govuk-list--bullet">
                  <li>name</li>
                  <li>address</li>
                  <li>date of birth</li>
                  <li>phone number</li>
                  <li>email address</li>
                  <li>TRN number</li>
                  <li>any other information you choose to share during the applicaiton process - for example, you can choose to share equality and diversity information</li>
                </ul>
              <h3 class="govuk-heading-s">What data we collect if you work for a training provider</h3>
                <p class="govuk-body">If you process teacher training applications, we may need to collect information about you so we can process applications, for example:</p>
                <ul class="govuk-list govuk-list--bullet">
                  <li>your name</li>
                  <li>your phone number</li>
                  <li>your email address</li>
                  <li>where you work</li>
                  <li>what your role is</li>
                </ul>

            <h2 class="govuk-heading-m">How we use your data</h2>
              <h3 class="govuk-heading-s">Processing applications</h3>
                <p class="govuk-body">Processing applications includes the following:</p>
                <ul class="govuk-list govuk-list--bullet">
                  <li>Sending applications to training providers</li>
                  <li>managing communications between candidates and training providers</li>
                  <li>working out and funding candidates are entitled to</li>
                  <li>getting in touch if there is a security issue around your data</li>
                  <li>getting in touch with candidates and training providers about their applications</li>
                </ul>
              <h3 class="govuk-heading-s">Building a better teacher training application process</h3>
                <p class="govuk-body">For example, we'll look at any feedback you give us about our services so we can improve them.</p>
                <p class="govuk-body">If you're an early career teacher or you work at a teacher training provider, we may contact you to carry out user research.</p>
              <h3 class="govuk-heading-s">Getting insight to make government policy better</h3>
                <p class="govuk-body">We might analyse your data to help us inform government policy around teacher recruitment and retention.</p>

            <h2 class="govuk-heading-m">Who we share your data with</h2>
              <p class="govuk-body">We do so under section 132 of the Education Act 2002, together with regulation 5 of the Education (School Teachers Qualifications) (England) Regulations 2003.</p>
              <h3 class="govuk-heading-s">Sharing data with teacher training providers</h3>
              <p class="govuk-body">We share early career teacher and mentor data with the teacher training providers the candidate applies to.</p>
              <p class="govuk-body">We have a data sharing agreement with providers so they can only use your data to:</p>
              <ul class="govuk-list govuk-list--bullet">
                <li>process agreements, which may include contacting candidates</li>
                <li>get statistics for internal use</li>
                <li>get in touch with you if there is a security issue concerning your data</li>
              </ul>

            <h2 class="govuk-heading-m">External organisations who process data</h2>
              <h3 class="govuk-heading-s">Customer service systems</h3>
                <p class="govuk-body">We use a customer service management system to process some personal data, such as feedback you send us.</p>
                <p class="govuk-body"><%= govuk_link_to 'Zendesk', "https://www.zendesk.co.uk/company/customers-partners/master-subscription-agreement/?cta=msa#confidentiality", class: "govuk-link" %> is currently our preferred customer service management system because it uses various safeguards to look after your data.</p>

              <h3 class="govuk-heading-s">Google</h3>
                <p class="govuk-body">We'll ask if you agree to cookies so that we can get statistics from Google Analytics. If you consent, Google may be able to get your IP address. We use Google Analytics for statistics and will not identify you personally from these.</p>
                <p class="govuk-body">We also use Google's G Suite to process some personal data. Google processes your data according to our instructions.</p>

              <h3 class="govuk-heading-s">Hosting services</h3>
                <p class="govuk-body">We host our services on GOV.UK PaaS, which encrypts your data to prevent it being accessed by unauthorised people.</p>

            <h2 class="govuk-heading-m">Your rights</h2>
              <p class="govuk-body">Under the Data Protection Act 2018, you have the right to find out what data we have about you. This includes the right to:</p>
              <ul class="govuk-list govuk-list--bullet">
                <li>be informed about how your data is being used</li>
                <li>access personal data</li>
                <li>have incorrect data updated</li>
                <li>have data erased</li>
                <li>stop or restrict the processing of your data</li>
                <li>get and reuse your data for different services</li>
                <li>object to how your data is processed in certain circumstances</li>
              </ul>
              <p class="govuk-body">You can find out more about how we handle personal data in our <%= govuk_link_to "personal information charter.", "https://www.gov.uk/government/organisations/department-for-education/about/personal-information-charter", class: "govuk-link" %></p>

            <h2 class="govuk-heading-m">Getting help and raising a concern</h2>
              <p class="govuk-body">If you want to ask us to remove your data or get access to the data we have about you, you can email us on:</p>

              <p><%= render MailToSupportComponent.new %></p>

              <p class="govuk-body">You can also use our contact form to <%= govuk_link_to "get in touch with our Data Protection Officer.", "https://form.education.gov.uk/en/AchieveForms/?form_uri=sandbox-publish://AF-Process-f1453496-7d8a-463f-9f33-1da2ac47ed76/AF-Stage-1e64d4cc-25fb-499a-a8d7-74e98203ac00/definition.json&redirectlink=%2Fen&cancelRedirectLink=%2Fen", class: "govuk-link" %></p>

              <p class="govuk-body">Once an early career teacher has enrolled with a teacher training provider, we will not be able to ask them to remove personal data from their systems. Please contact the provider separately.</p>
              <p class="govuk-body">For further information or to raise a concern, visit the <%= govuk_link_to "Information Commissioner's Office.", "https://ico.org.uk/" %></p>

            <h2 class="govuk-heading-m">Keeping our privacy policy up to date</h2>
            <p class="govuk-body">We reserve the right to update this privacy notice at any time, and we will provide you with a new privacy notice when we make any substantial updates. We will also notify you in other ways from time to time about the processing of your personal information.</p>
          PRIVACY_POLICY
        )
      end
    end
  end
end
