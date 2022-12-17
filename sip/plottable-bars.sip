/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */

class QCPBarsGroup : public QObject
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  enum SpacingType { stAbsolute       ///< Bar spacing is in absolute pixels
                     ,stAxisRectRatio ///< Bar spacing is given by a fraction of the axis rect size
                     ,stPlotCoords    ///< Bar spacing is in key coordinates and thus scales with the key axis range
                   };

  QCPBarsGroup(QCustomPlot *parentPlot /TransferThis/);
  virtual ~QCPBarsGroup();

  // getters:
  SpacingType spacingType() const;
  double spacing() const;

  // setters:
  void setSpacingType(SpacingType spacingType);
  void setSpacing(double spacing);

  // non-virtual methods:
  QList<QCPBars*> bars() const;
  QCPBars* bars(int index) const;
  int size() const;
  bool isEmpty() const;
  void clear();
  bool contains(QCPBars *bars) const;
  void append(QCPBars *bars);
  void insert(int i, QCPBars *bars);
  void remove(QCPBars *bars);

protected:
  // non-virtual methods:
  void registerBars(QCPBars *bars);
  void unregisterBars(QCPBars *bars);

  // virtual methods:
  double keyPixelOffset(const QCPBars *bars, double keyCoord);
  double getPixelSpacing(const QCPBars *bars, double keyCoord);
};


class QCPBarsData
{
%TypeHeaderCode
#include <qcustomplot.h>

typedef QCPAbstractPlottable1D<QCPBarsData> QCPAbstractPlottable1D_QCPBarsData;
%End
public:
  QCPBarsData();
  QCPBarsData(double key, double value);

  double sortKey() const;
  static QCPBarsData fromSortKey(double sortKey);
  static bool sortKeyIsMainKey();

  double mainKey() const;
  double mainValue() const;

  QCPRange valueRange() const; // note that bar base value isn't held in each QCPBarsData and thus can't/shouldn't be returned here

  double key;
  double value;
};


typedef QCPAbstractPlottable1D<QCPBarsData> QCPAbstractPlottable1D_QCPBarsData;
typedef QCPDataContainer<QCPBarsData> QCPBarsDataContainer;
typedef QCPDataContainerIterator<QCPBarsData> QCPBarsDataContainerIterator;


class QCPBars : public QCPAbstractPlottable1D_QCPBarsData
{
%TypeHeaderCode
#include <qcustomplot.h>

typedef QCPAbstractPlottable1D<QCPBarsData> QCPAbstractPlottable1D_QCPBarsData;
%End
public:
  enum WidthType { wtAbsolute       ///< Bar width is in absolute pixels
                   ,wtAxisRectRatio ///< Bar width is given by a fraction of the axis rect size
                   ,wtPlotCoords    ///< Bar width is in key coordinates and thus scales with the key axis range
                 };

  // TODO: Technically ownership is trasferred to keyAxis->parentPlot()
  explicit QCPBars(QCPAxis *keyAxis /TransferThis/, QCPAxis *valueAxis);
  virtual ~QCPBars();

  // getters:
  double width() const;
  WidthType widthType() const;
  QCPBarsGroup *barsGroup() const;
  double baseValue() const;
  double stackingGap() const;
  QCPBars *barBelow() const;
  QCPBars *barAbove() const;
  QCPBarsDataContainer *data() const;
  %MethodCode
    // QSharedPointer::get was introduced in Qt 5.11
    sipRes = sipCpp->data().data();
  %End

  // setters:
  void setData(QCPBarsDataContainer *data);
  %MethodCode
    sipCpp->setData(QSharedPointer<QCPBarsDataContainer>(a0));
  %End
  void setData(const QVector<double> &keys, const QVector<double> &values, bool alreadySorted=false);
  void setWidth(double width);
  void setWidthType(WidthType widthType);
  void setBarsGroup(QCPBarsGroup *barsGroup);
  void setBaseValue(double baseValue);
  void setStackingGap(double pixels);

  // non-property methods:
  void addData(const QVector<double> &keys, const QVector<double> &values, bool alreadySorted=false);
  void addData(double key, double value);
  void moveBelow(QCPBars *bars);
  void moveAbove(QCPBars *bars);

  // reimplemented virtual methods:
  virtual QCPDataSelection selectTestRect(const QRectF &rect, bool onlySelectable) const;
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;
  virtual QCPRange getKeyRange(bool &foundRange, QCP::SignDomain inSignDomain=QCP::sdBoth) const;
  virtual QCPRange getValueRange(bool &foundRange, QCP::SignDomain inSignDomain=QCP::sdBoth, const QCPRange &inKeyRange=QCPRange()) const;
  virtual QPointF dataPixelPosition(int index) const;

protected:
  // reimplemented virtual methods:
  virtual void draw(QCPPainter *painter);
  virtual void drawLegendIcon(QCPPainter *painter, const QRectF &rect) const;

  // non-virtual methods:
//   void getVisibleDataBounds(QCPBarsDataContainer::const_iterator &begin, QCPBarsDataContainer::const_iterator &end) const;
  QRectF getBarRect(double key, double value) const;
  void getPixelWidth(double key, double &lower, double &upper) const;
  double getStackedBaseValue(double key, bool positive) const;
  static void connectBars(QCPBars *lower, QCPBars *upper);
};


