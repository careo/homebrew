require 'brewkit'

class Scons <Formula
  @url='http://prdownloads.sourceforge.net/scons/scons-1.2.0.tar.gz'
  @homepage=''
  @md5='53b6aa7281811717a57598e319441cf7'

  def install
    system "python setup.py install --prefix=#{prefix}"
  end
end
