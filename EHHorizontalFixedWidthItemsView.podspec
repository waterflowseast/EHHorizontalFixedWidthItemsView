Pod::Spec.new do |s|
  s.name             = 'EHHorizontalFixedWidthItemsView'
  s.version          = '1.0.1'
  s.summary          = 'a view which arranges same-size item views one by one horizontally.'

  s.description      = <<-DESC
EHHorizontalFixedWidthItemsView: a view which arranges same-size item views one by one horizontally.
EHHorizontalFixedWidthItemsSeparatorView: EHHorizontalFixedWidthItemsView + separator lines.
EHHorizontalFixedWidthItemsSelectionView: selection version of EHHorizontalFixedWidthItemsView, you can single-select or multiple-select.
EHFixedWidthItemsSequentialSelectionView: sequentail selection version of EHHorizontalFixedWidthItemsView.
EHRateView: image version of EHFixedWidthItemsSequentialSelectionView.
EHFixedWidthItemsSingleAnimatedSelectionView: a view which arranges same-size item views one by one horizontally, when you select one item, it automatically unselect the previous selected one with animation.
EHFixedWidthItemsSingleAnimatedSelectionSeparatorView: EHFixedWidthItemsSingleAnimatedSelectionView + separator lines.
EHHorizontalFixedWidthItemsTrackView: a view which arranges same-size item views one by one horizontally and has a track on the bottom. when you select one item, the track will slide to the selected one with animation.
                       DESC

  s.homepage         = 'https://github.com/waterflowseast/EHHorizontalFixedWidthItemsView'
  s.screenshots     = 'https://github.com/waterflowseast/EHHorizontalFixedWidthItemsView/raw/master/screenshots/1.png', 'https://github.com/waterflowseast/EHHorizontalFixedWidthItemsView/raw/master/screenshots/2.png', 'https://github.com/waterflowseast/EHHorizontalFixedWidthItemsView/raw/master/screenshots/3.png', 'https://github.com/waterflowseast/EHHorizontalFixedWidthItemsView/raw/master/screenshots/4.png', 'https://github.com/waterflowseast/EHHorizontalFixedWidthItemsView/raw/master/screenshots/5.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Eric Huang' => 'WaterFlowsEast@gmail.com' }
  s.source           = { :git => 'https://github.com/waterflowseast/EHHorizontalFixedWidthItemsView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '7.0'
  s.source_files = 'EHHorizontalFixedWidthItemsView/Classes/**/*'
  s.dependency 'EHItemViewCommon', '~> 1.0.1'
end
